module 0x3d67a96a86672808c5c228e9cca46e30708552ec215950c8f8c38b398b4be947::icon {
    public(friend) fun get_icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://ibb.co/hYy9NCL")
    }

    public(friend) fun get_icon_url_by_url() : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(b"https://ibb.co/hYy9NCL"))
    }

    // decompiled from Move bytecode v6
}

