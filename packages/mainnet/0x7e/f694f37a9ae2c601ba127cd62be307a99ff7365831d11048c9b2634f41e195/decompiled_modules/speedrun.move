module 0x7ef694f37a9ae2c601ba127cd62be307a99ff7365831d11048c9b2634f41e195::speedrun {
    struct SPEEDRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDRUN>(arg0, 9, b"speedrun", b"World Record Fastest $100M Run", x"576f726c64205265636f7264204661737465737420243130304d2052756e6e6572200d0a0d0a492077696c6c206265206c6f636b696e67207468652064657620737570706c7920666f7220352079656172732e200d0a0d0a5765206861766520746f2073656e64207468697320746f20243130304d20756e6465722032344820746f2070726f7665206120706f696e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX7BcTTz3vAwthuugh9Tq3bAjdXE1EjLKUgfn7kaygL84")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPEEDRUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEEDRUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDRUN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

