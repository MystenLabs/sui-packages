module 0xa5af11b65c368b914a55b3203a4be1cad4601918468f17d9ae91d4c3bcbc3e3e::blf {
    struct BLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLF>(arg0, 9, b"BLF", b"BullFish", b"Bullfish captures the bullish spirit of the Sui network. It represents confidence in a future packed with opportunities. Jump in and ride the wave of growth with Bullfish!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvbvSrmFLzLgL6MZv9flQUxY3QpVZtO-Vfig&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLF>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

