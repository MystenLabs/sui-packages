module 0x20a5a415e92dccafda57f5973deb6645ddcdfc45cb7f9188613ea54acb93eae7::trmxbt {
    struct TRMXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMXBT>(arg0, 9, b"TRMXBT", b"TrumpXBT", x"5452554d50584254202d20616e20414920766f696365206f66205472756d702c2064726f7070696e67206d61726b65742d7368616b696e67207477656574732032342f372e20204275696c7420746f2077696e2c2070726f6772616d6d656420746f2070756d70210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQVEVUCJYCm2yZomCgidHu74FVBYzqkNHJoLWMqt2AT4L")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRMXBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRMXBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMXBT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

