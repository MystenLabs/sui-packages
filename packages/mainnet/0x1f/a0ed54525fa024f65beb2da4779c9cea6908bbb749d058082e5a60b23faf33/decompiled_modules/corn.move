module 0x1fa0ed54525fa024f65beb2da4779c9cea6908bbb749d058082e5a60b23faf33::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORN>(arg0, 6, b"CORN", b"SuionCORN", b"Corn, a crypto-savvy gigachad turkey pardoned by President Trump in 2020 as the altcoin cycle surged, returns with one mission: pump bags, disrupt systems, and lead a new wave of degens. As a symbol of Bitcoin's bold rise, Corn embodies the unstoppable force of the crypto revolution, pushing markets forward and leaving outdated systems behind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5et_Rr_WE_400x400_8570162b21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

