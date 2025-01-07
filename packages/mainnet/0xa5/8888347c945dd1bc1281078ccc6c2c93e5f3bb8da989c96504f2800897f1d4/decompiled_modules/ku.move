module 0xa58888347c945dd1bc1281078ccc6c2c93e5f3bb8da989c96504f2800897f1d4::ku {
    struct KU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KU>(arg0, 9, b"KU", b"Kukur ", b"Kukur is a meme inspired by the spirit of adventure  and freedom  with kukur we are not just riding the kukur  - we are mostering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49f16914-b888-4435-afd5-a69bc51ac4e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KU>>(v1);
    }

    // decompiled from Move bytecode v6
}

