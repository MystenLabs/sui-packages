module 0x6b0cefe23a245beebfc9a99979daf450e605b6503efbc3deaf63404b9092cc24::SCOOB {
    struct SCOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOOB>(arg0, 9, b"SCOOBY SOLA", b"SCOOB", b"Introducing the SCOOB, a meme cute that builds upon the resounding success of SCOOB on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1750104581084700673/gyKKg2rF_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCOOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCOOB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCOOB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

