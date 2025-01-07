module 0xfb245f94232ba00f078e90839b742930261192793643a58e24e019cc26d98d7d::frieza {
    struct FRIEZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIEZA>(arg0, 6, b"Frieza", b"DragonBall Frieza", b"dragon ball master", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kdr5u_A_afa242875e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIEZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

