module 0xaafe4cafdcc559ad8362b314c9cb821559f85fe93360e51d0fb251db36302e92::grgrgrgrgrgrgrgrgrgr {
    struct GRGRGRGRGRGRGRGRGRGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRGRGRGRGRGRGRGRGRGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRGRGRGRGRGRGRGRGRGR>(arg0, 9, b"grgrgrgrgrgrgrgrgrgr", b"BOO", b"Official token of boo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/diceblock/images/d/da/600px-BooNSMBWii-1-.png/revision/latest/scale-to-width-down/250?cb=20181109170546")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRGRGRGRGRGRGRGRGRGR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRGRGRGRGRGRGRGRGRGR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRGRGRGRGRGRGRGRGRGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

