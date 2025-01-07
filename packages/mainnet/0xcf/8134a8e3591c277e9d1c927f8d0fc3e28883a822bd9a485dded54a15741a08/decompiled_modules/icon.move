module 0xcf8134a8e3591c277e9d1c927f8d0fc3e28883a822bd9a485dded54a15741a08::icon {
    public(friend) fun get_icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://ibb.co/hYy9NCL")
    }

    public(friend) fun get_icon_url_by_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://ibb.co/hYy9NCL")
    }

    // decompiled from Move bytecode v6
}

