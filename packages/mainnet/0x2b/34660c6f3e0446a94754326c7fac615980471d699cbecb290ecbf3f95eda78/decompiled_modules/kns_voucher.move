module 0x2b34660c6f3e0446a94754326c7fac615980471d699cbecb290ecbf3f95eda78::kns_voucher {
    struct KNSVoucher has store, key {
        id: 0x2::object::UID,
    }

    struct KNS_VOUCHER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VoucherMinted has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct VoucherBurned has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun airdrop(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = KNSVoucher{id: 0x2::object::new(arg2)};
        let v1 = VoucherMinted{object_id: 0x2::object::id<KNSVoucher>(&v0)};
        0x2::event::emit<VoucherMinted>(v1);
        0x2::transfer::public_transfer<KNSVoucher>(v0, arg1);
    }

    public fun airdrop_multi(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            airdrop(arg0, 0x1::vector::pop_back<address>(&mut arg1), arg2);
            v0 = v0 + 1;
        };
    }

    public fun burn(arg0: KNSVoucher, arg1: &mut 0x2::tx_context::TxContext) {
        let KNSVoucher { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = VoucherBurned{object_id: 0x2::object::id<KNSVoucher>(&arg0)};
        0x2::event::emit<VoucherBurned>(v1);
    }

    fun init(arg0: KNS_VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Karrier Number System Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.karrier.one/kns-early-adopter/kns-voucher-nft.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"One free activation of the Karrier Number System. (KNS)"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://kns-dev.karrier.one"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Karrier One Team"));
        let v4 = 0x2::package::claim<KNS_VOUCHER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KNSVoucher>(&v4, v0, v2, arg1);
        0x2::display::update_version<KNSVoucher>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<KNSVoucher>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

