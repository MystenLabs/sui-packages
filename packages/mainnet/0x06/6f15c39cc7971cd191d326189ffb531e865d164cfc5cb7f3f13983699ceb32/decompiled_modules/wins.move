module 0x66f15c39cc7971cd191d326189ffb531e865d164cfc5cb7f3f13983699ceb32::wins {
    struct WINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINS>(arg0, 6, b"WINS", b"Wins Winner", b"Wins - Memecoin for winners like you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014598_e1e24b016d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

