module 0x5cbed4d7c7a66a9b44d95fbf6f770ba100216375ce9d83e6566e9d98b4794928::pwup {
    struct PWUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWUP>(arg0, 6, b"PWUP", b"PWUP ON SUI", b"PWUP NOW ON SUI. LETS BUY, REACH BONDING IN MINUTES BUDDIES! PROMISE NO RUG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Captura_de_pantalla_2024_09_25_005121_4949b6965a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

