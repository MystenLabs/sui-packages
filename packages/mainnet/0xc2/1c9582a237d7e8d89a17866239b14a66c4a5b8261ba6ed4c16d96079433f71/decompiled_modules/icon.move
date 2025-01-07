module 0xc21c9582a237d7e8d89a17866239b14a66c4a5b8261ba6ed4c16d96079433f71::icon {
    public(friend) fun get_icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/xFDLb3X/1.jpg")
    }

    // decompiled from Move bytecode v6
}

