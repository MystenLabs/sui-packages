module 0x644eabd3cf8a3cf165ba26a527055bbee95ab1e0f654ec999e57238ce5506f4a::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 9, b"aaaa", b"aaaa", b"aaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgs.search.brave.com/8coJokoIvvLuhKr8K2jgoi5LBGJCYBeml_2AK5Rsx04/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9wcmV2/aWV3LnJlZGQuaXQv/cGQ3dWRzd3E3NzA3/MS5wbmc_d2lkdGg9/NjQwJmNyb3A9c21h/cnQmYXV0bz13ZWJw/JnM9YmNhZWJiZTk2/MWViZWM3N2VmYzVk/ZTY1OTUxZTljOWUz/ZGU3YzU2YQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

