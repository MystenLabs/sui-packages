module 0x8aaf8d100172edf2e798022604d0cdc10d740e738d71cab218fd680df0d789d2::norug {
    struct NORUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORUG>(arg0, 6, b"NORUG", b"Norug", x"244e4f5255473a20456e737572696e6720612053616665722043727970746f20456e7669726f6e6d656e740a4a6f696e20244e4f52554720616e64207265766f6c7574696f6e697a6520746865206d656d652063727970746f63757272656e6379206c616e64736361706521204f7572206d697373696f6e20697320746f20637265617465206120736166652c207472616e73706172656e7420737061636520666f7220696e766573746d656e74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727484449614_ea5417cc3842eeef09aa84987708f438_bf49fd8eac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

