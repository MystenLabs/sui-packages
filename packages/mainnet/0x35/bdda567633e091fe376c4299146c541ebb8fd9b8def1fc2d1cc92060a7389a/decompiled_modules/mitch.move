module 0x35bdda567633e091fe376c4299146c541ebb8fd9b8def1fc2d1cc92060a7389a::mitch {
    struct MITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITCH>(arg0, 6, b"MITCH", b"retardionaire", b"The coins Mitch holds on Sui when they go up $MITCH will go up, This is a community token Some supply will be airdropped to Mitch, the community will be left to make a TG and a website if they would like :) DON'T FADE $MITCH....   ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DKJX_2398_a3de2d4b61.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

