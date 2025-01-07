module 0xc5cb7ec141f66ede73c4840c9cffdaccb4554083e4a1d62bd545d9c014742e69::bdag {
    struct BDAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDAG>(arg0, 6, b"BDAG", b"BlockDAG ($BDAG)", x"243132324d2b2072616973656420616e64206578636c75736976652061697264726f7020616363657373206f6e20746865206c696e652c207468697320697320796f757220676f6c64656e207469636b657420746f2072696465207468652042756c6c2052756e21200a446f6ee2809974206d69737320796f7572206368616e636520746f20646f75626c6520796f757220696d7061637420616e642073656375726520796f75722073706f7420696e2074686520667574757265206f6620646563656e7472616c697a65642066696e616e63652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732174908422.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

