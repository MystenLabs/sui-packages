module 0x337ea4b2d7372814b95dd45e70ff540de9ae0f38c523f0de8cbf0012c44f0623::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"SUI's DOg", b"Sui dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-ext-1.discordapp.net/external/kWac27v41wkWZ5DzbG1ki9KH3ofV3TtOSysNqqKCzRU/https/pbs.twimg.com/media/GaSLddaXwAA4GoB.jpg%3Alarge?format=webp&width=1128&height=1128")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<SUI>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<SUI>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

