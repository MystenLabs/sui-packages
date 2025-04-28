module 0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::display {
    struct DISPLAY has drop {
        dummy_field: bool,
    }

    fun create_badge_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::basecamp25_badge::Badge> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUI Basecamp 2025"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://collect.claynosaurz.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This achievement commemorates your participation in the SUI Base Camp 2025. It unlocks a free Popkins Mystery Pack to claim at the time of mint. Will you Unleash a Popkin?"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://claynosaurz.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claynosaurz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        let v4 = 0x2::display::new_with_fields<0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::basecamp25_badge::Badge>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::basecamp25_badge::Badge>(&mut v4);
        v4
    }

    fun init(arg0: DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DISPLAY>(arg0, arg1);
        let v1 = create_badge_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::basecamp25_badge::Badge>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

