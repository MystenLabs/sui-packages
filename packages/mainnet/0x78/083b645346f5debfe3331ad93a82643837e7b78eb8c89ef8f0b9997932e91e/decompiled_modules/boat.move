module 0x78083b645346f5debfe3331ad93a82643837e7b78eb8c89ef8f0b9997932e91e::boat {
    struct BOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOAT>(arg0, 9, b"BOAT", b"boat", x"5361696c20696e746f2070726f66697473207769746820426f6174436f696e3a205468652063727970746f63757272656e637920746861742773206e617669676174696e67207468652066696e616e6369616c20736561732c2064656c69766572696e6720736d6f6f7468207361696c696e6720616e642074726561737572652d66696c6c65642072657475726e7320746f20796f757220706f7274666f6c696f2120e29bb5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9023b56-09eb-4f3f-af36-dc02deb1319b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

