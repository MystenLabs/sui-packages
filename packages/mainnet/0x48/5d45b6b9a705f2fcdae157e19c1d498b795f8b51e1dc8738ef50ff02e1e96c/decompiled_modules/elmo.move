module 0x485d45b6b9a705f2fcdae157e19c1d498b795f8b51e1dc8738ef50ff02e1e96c::elmo {
    struct ELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMO>(arg0, 9, b"ELMO", b"ElonMoon", b"The name \"ElonMoon\" was inspired by Elon Musk's popularity, which is often associated with the crypto world, and the term \"to the moon\" which is popular among crypto investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9187e7f0-36ff-4aba-bc76-91f74a8d01be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

