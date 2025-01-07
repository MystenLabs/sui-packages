module 0x3ccdb239c30a49113785d373f9ade9d938d99d7b649c8a6bf8f7aa7bdf5f714e::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 9, b"PUMP", b"Pump On Sui", b"The trainer behind the rise of every pumping dog and cat meme. Built on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848138816386715648/eVhmREIa_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

