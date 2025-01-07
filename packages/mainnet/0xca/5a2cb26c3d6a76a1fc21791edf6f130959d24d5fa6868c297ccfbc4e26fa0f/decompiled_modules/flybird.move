module 0xca5a2cb26c3d6a76a1fc21791edf6f130959d24d5fa6868c297ccfbc4e26fa0f::flybird {
    struct FLYBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYBIRD>(arg0, 9, b"FLYBIRD", b"WAWE", b"Fly Bird Is To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f2940c0-c0c0-4570-bd1d-a620682f8e8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLYBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

