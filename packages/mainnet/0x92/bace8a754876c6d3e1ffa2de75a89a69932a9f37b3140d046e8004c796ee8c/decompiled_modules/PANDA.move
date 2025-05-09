module 0x92bace8a754876c6d3e1ffa2de75a89a69932a9f37b3140d046e8004c796ee8c::PANDA {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"Space Panda", b"The chillest coolest panda who's just a dude.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmT31z2KXbQaoihKddSmKa6bQCtXEnqW83TPThogFxJfsH")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

