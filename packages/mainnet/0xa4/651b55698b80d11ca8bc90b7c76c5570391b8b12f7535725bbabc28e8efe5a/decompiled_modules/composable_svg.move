module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::composable_svg {
    struct ComposableSvg has store {
        nfts: vector<0x2::object::ID>,
        attributes: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
        svg: vector<u8>,
    }

    struct RenderGuard {
        children: vector<0x2::object::ID>,
        svg: vector<u8>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: ComposableSvg) {
        assert_no_composable_svg(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableSvg>, ComposableSvg>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableSvg>(), arg1);
    }

    public fun add_from_attributes(arg0: &mut 0x2::object::UID, arg1: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) {
        add_domain(arg0, from_attributes(arg1));
    }

    public fun add_new(arg0: &mut 0x2::object::UID) {
        add_domain(arg0, new());
    }

    public fun assert_composable_svg(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_no_composable_svg(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_attributes(arg0: &ComposableSvg) : &0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        &arg0.attributes
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &ComposableSvg {
        assert_composable_svg(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableSvg>, ComposableSvg>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableSvg>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut ComposableSvg {
        assert_composable_svg(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableSvg>, ComposableSvg>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableSvg>())
    }

    public fun borrow_nfts(arg0: &ComposableSvg) : &vector<0x2::object::ID> {
        &arg0.nfts
    }

    public fun borrow_svg(arg0: &ComposableSvg) : &vector<u8> {
        &arg0.svg
    }

    public fun borrow_svg_nft(arg0: &0x2::object::UID) : &vector<u8> {
        borrow_svg(borrow_domain(arg0))
    }

    public fun delete(arg0: ComposableSvg) {
        let ComposableSvg {
            nfts       : _,
            attributes : _,
            svg        : _,
        } = arg0;
    }

    public fun deregister(arg0: &mut ComposableSvg, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(borrow_nfts(arg0), &arg1);
        assert!(v0, 3);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.nfts, v1);
    }

    public fun deregister_nft(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        let v0 = borrow_domain_mut(arg0);
        deregister(v0, arg1);
    }

    public fun finish_render(arg0: RenderGuard, arg1: &mut ComposableSvg) {
        let RenderGuard {
            children : v0,
            svg      : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::vector::length<0x2::object::ID>(&v3) == 0, 5);
        0x1::vector::append<u8>(&mut v2, b"</svg>");
        arg1.svg = v2;
    }

    public fun finish_render_nft(arg0: RenderGuard, arg1: &mut 0x2::object::UID) {
        let v0 = borrow_domain_mut(arg1);
        finish_render(arg0, v0);
    }

    public fun from_attributes(arg0: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) : ComposableSvg {
        ComposableSvg{
            nfts       : 0x1::vector::empty<0x2::object::ID>(),
            attributes : arg0,
            svg        : 0x1::vector::empty<u8>(),
        }
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableSvg>, ComposableSvg>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableSvg>())
    }

    public fun new() : ComposableSvg {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0, 0x1::ascii::string(b"xmlns"), 0x1::ascii::string(b"http://www.w3.org/2000/svg"));
        from_attributes(v0)
    }

    public fun register(arg0: &mut ComposableSvg, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.nfts, arg1);
    }

    public fun register_nft(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        let v0 = borrow_domain_mut(arg0);
        register(v0, arg1);
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : ComposableSvg {
        assert_composable_svg(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<ComposableSvg>, ComposableSvg>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<ComposableSvg>())
    }

    public fun render_child(arg0: &mut RenderGuard, arg1: &0x2::object::UID) {
        render_child_(arg0, 0x2::object::uid_as_inner(arg1), *0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::svg::get_svg(0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::svg::borrow_domain(arg1)));
    }

    fun render_child_(arg0: &mut RenderGuard, arg1: &0x2::object::ID, arg2: vector<u8>) {
        0x1::vector::append<u8>(&mut arg0.svg, b"<g>");
        0x1::vector::append<u8>(&mut arg0.svg, arg2);
        0x1::vector::append<u8>(&mut arg0.svg, b"</g>");
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&mut arg0.children, arg1);
        assert!(v0, 4);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.children, v1);
    }

    public fun render_child_external(arg0: &mut RenderGuard, arg1: &mut 0x2::object::UID, arg2: vector<u8>) {
        render_child_(arg0, 0x2::object::uid_as_inner(arg1), arg2);
    }

    public fun start_render(arg0: &ComposableSvg) : RenderGuard {
        let v0 = borrow_attributes(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, b"<svg");
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<0x1::ascii::String, 0x1::ascii::String>(v0)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::ascii::String, 0x1::ascii::String>(v0, v2);
            0x1::vector::append<u8>(&mut v1, b" ");
            0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(*v3));
            0x1::vector::append<u8>(&mut v1, b"=\"");
            0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(*v4));
            0x1::vector::append<u8>(&mut v1, b"\"");
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v1, b">");
        RenderGuard{
            children : arg0.nfts,
            svg      : v1,
        }
    }

    public fun start_render_nft(arg0: &0x2::object::UID) : RenderGuard {
        start_render(borrow_domain(arg0))
    }

    // decompiled from Move bytecode v6
}

