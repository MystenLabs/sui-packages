module 0xfa1a31a58aac27568b0d5b3fa411db5d428b61eeed8e5a99c7a9ffd420a9a2c7::dbt {
    struct DBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DBT>(arg0, 5540421991961845552, b"Don't buy this!", b"DBT", b"Just don't...", b"https://images.hop.ag/ipfs/Qma5HUDNiUJfHyJEeFFYSie9p3beWNCFZYSsGy8j491umh", 0x1::string::utf8(b"https://x.com"), 0x1::string::utf8(b"https://website.com"), 0x1::string::utf8(b"https://t.me"), arg1);
    }

    // decompiled from Move bytecode v6
}

