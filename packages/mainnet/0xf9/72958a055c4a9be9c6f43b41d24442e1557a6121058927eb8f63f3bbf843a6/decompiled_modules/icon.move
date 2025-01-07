module 0xf972958a055c4a9be9c6f43b41d24442e1557a6121058927eb8f63f3bbf843a6::icon {
    public(friend) fun get_icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://ibb.co/hYy9NCL")
    }

    public(friend) fun get_icon_url_by_url() : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(b"https://ibb.co/hYy9NCL"))
    }

    // decompiled from Move bytecode v6
}

