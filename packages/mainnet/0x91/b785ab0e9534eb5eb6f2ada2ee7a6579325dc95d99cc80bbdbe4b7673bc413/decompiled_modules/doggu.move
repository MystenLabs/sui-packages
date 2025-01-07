module 0x91b785ab0e9534eb5eb6f2ada2ee7a6579325dc95d99cc80bbdbe4b7673bc413::doggu {
    struct DOGGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGU>(arg0, 6, b"DOGGU", b"Doggu ON SUI", b"dog with the butter on him. $DOGGU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_O_Enzvp_P_400x400_2d3581f5e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

