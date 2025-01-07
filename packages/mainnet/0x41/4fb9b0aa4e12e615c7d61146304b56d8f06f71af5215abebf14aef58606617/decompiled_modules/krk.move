module 0x414fb9b0aa4e12e615c7d61146304b56d8f06f71af5215abebf14aef58606617::krk {
    struct KRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRK>(arg0, 9, b"KRK", b"KIRIK", b"KIRIK IS DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b09331d1-7291-4fc2-a9a3-c8e2ced60433-1000174278.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

