module 0xf2ea80bfb1746a071dc17d019bee936f8ba649302ceb390ccfa83a35133d3608::senpai {
    struct SENPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENPAI>(arg0, 9, b"SENPAI", b"My Friend Senpai", b"mi amigo el senpai es una gran perzona", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scontent.fbhi9-1.fna.fbcdn.net/v/t39.30808-1/313364298_107298908850176_1603480705435923664_n.jpg?stp=dst-jpg_s200x200&_nc_cat=100&ccb=1-7&_nc_sid=0ecb9b&_nc_eui2=AeGgsfUrOEzgUVzltU9zY1VZxH-2DKB5MBvEf7YMoHkwG4CFYiZHPyVq2II5rV8Ijn84kbY4-EM5bf7lGTgFlkEH&_nc_ohc=1qPv_tU4lv4Q7kNvgGNj3xw&_nc_ht=scontent.fbhi9-1.fna&_nc_gid=A9l6eQsagnrqpW3YJ2BO9Vg&oh=00_AYC-GAKpnKFrN_la5budB_DdEk0mBAWk4uoUCyHzyIFNMw&oe=66FC2EAC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SENPAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENPAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

