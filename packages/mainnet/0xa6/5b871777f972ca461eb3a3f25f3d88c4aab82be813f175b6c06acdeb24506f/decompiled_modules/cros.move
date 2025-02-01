module 0xa65b871777f972ca461eb3a3f25f3d88c4aab82be813f175b6c06acdeb24506f::cros {
    struct CROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROS>(arg0, 6, b"CROS", b"CucarachaOnSui", b"Hello everyone! Join Cucaracha in conquering new challenges at Suinetwork!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5b83889d_8633_4aed_872b_21d183bce69a_43b7b03937.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

