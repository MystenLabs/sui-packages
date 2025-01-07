module 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::display {
    fun info_stamp(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Info, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Container>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.ambrus.studio/E4CFSAssets/InfoStamp/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.tier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.attributes}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Info stamps store all your in-game achievements."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.ambrus.studio/"));
        let v4 = 0x2::display::new_with_fields<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Info, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Container>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Info, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Container>>(&mut v4);
        v4
    }

    public fun setup_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin::Skin>(arg0), 0);
        let v0 = skin(arg0, arg1);
        let v1 = info_stamp(arg0, arg1);
        let v2 = skin_stamp(arg0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin::Skin>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Info, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type::Container>>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun skin(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin::Skin> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"final_salvation_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"guid"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"max_num_stamps_slot"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"current_num_stamps"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"stamps"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"champion_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.ambrus.studio/E4CFSAssets/Skin/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{final_salvation_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{guid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{max_num_stamps_slot}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{current_num_stamps}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{stamps}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{champion_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Playable champion skin in E4C: Final Salvation"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.ambrus.studio"));
        let v4 = 0x2::display::new_with_fields<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin::Skin>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin::Skin>(&mut v4);
        v4
    }

    fun skin_stamp(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"fs_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"guid"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"champion_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"skin_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"effects"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.ambrus.studio/E4CFSAssets/SkinStamp/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.tier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.attributes}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.fs_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.guid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.champion_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.skin_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{container.effects}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Equip skin stamps to a champion skin to show extra in-game visual effects and more!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.ambrus.studio/"));
        let v4 = 0x2::display::new_with_fields<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Skin, 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type::Container>>(&mut v4);
        v4
    }

    // decompiled from Move bytecode v6
}

