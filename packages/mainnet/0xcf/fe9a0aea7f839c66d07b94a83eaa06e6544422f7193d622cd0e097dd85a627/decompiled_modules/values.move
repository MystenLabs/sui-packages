module 0xcffe9a0aea7f839c66d07b94a83eaa06e6544422f7193d622cd0e097dd85a627::values {
    public fun display_creator_value() : 0x1::string::String {
        0x1::string::utf8(b"dWallet Labs / Rhei / Anima Labs / Studio Mirai")
    }

    public fun display_domain_url() : 0x1::string::String {
        0x1::string::utf8(b"https://ika.rhei.finance")
    }

    public fun display_project_url() : 0x1::string::String {
        0x1::string::utf8(b"https://mfsmnft.walrus.site/")
    }

    public fun get_image_url(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = display_domain_url();
        0x1::string::append(&mut v0, arg0);
        v0
    }

    public fun please_apply_msg() : 0x1::string::String {
        0x1::string::utf8(b"Congrats, now DM Illumi to apply!")
    }

    public fun royalty_bps() : u16 {
        690
    }

    // decompiled from Move bytecode v6
}

