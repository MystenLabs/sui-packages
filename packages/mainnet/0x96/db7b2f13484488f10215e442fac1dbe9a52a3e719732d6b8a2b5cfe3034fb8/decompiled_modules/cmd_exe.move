module 0x96db7b2f13484488f10215e442fac1dbe9a52a3e719732d6b8a2b5cfe3034fb8::cmd_exe {
    struct CMD_EXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMD_EXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMD_EXE>(arg0, 9, b"cmd_exe", b"CowboyMonkeyDuck.exe", b"C:\\CowboyMonkeyDuck\\Degen\\FullPort>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GevMhaMtYtvv44pnkaoyBewrTuAK9x532xo55MTjpump.png?size=lg&key=1ba56b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CMD_EXE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMD_EXE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMD_EXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

