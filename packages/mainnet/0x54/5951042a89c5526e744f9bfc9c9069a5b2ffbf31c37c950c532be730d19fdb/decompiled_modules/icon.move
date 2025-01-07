module 0x545951042a89c5526e744f9bfc9c9069a5b2ffbf31c37c950c532be730d19fdb::icon {
    public(friend) fun get_icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"")
    }

    public(friend) fun get_icon_url_by_url() : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(b"https://ibb.co/hYy9NCL"))
    }

    // decompiled from Move bytecode v6
}

