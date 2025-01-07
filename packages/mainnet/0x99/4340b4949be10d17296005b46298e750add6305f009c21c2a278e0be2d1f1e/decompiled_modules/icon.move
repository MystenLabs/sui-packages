module 0x994340b4949be10d17296005b46298e750add6305f009c21c2a278e0be2d1f1e::icon {
    public(friend) fun get_icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://lexica.art/prompt/e37e4ffb-201a-4638-9445-de094d73fffc")
    }

    // decompiled from Move bytecode v6
}

