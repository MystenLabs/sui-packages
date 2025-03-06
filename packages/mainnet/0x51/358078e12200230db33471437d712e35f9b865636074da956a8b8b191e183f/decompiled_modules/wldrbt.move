module 0x51358078e12200230db33471437d712e35f9b865636074da956a8b8b191e183f::wldrbt {
    struct WLDRBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLDRBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLDRBT>(arg0, 9, b"WLDRBT", b"The Wild Robot", b"After a shipwreck, an intelligent robot called Roz is stranded on an uninhabited island. To survive the harsh environment, Roz bonds with the island's animals and cares for an orphaned baby goose.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/WLDRBT.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WLDRBT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLDRBT>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLDRBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

