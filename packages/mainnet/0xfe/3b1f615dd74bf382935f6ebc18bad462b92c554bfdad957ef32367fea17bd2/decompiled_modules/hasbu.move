module 0xfe3b1f615dd74bf382935f6ebc18bad462b92c554bfdad957ef32367fea17bd2::hasbu {
    struct HASBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASBU>(arg0, 6, b"HASBU", b"Hasbullah", x"48617362756c6c616820697320656e746572696e67207468652053554920776f726c64202121210a0a4a757374206b65657020646f6e6174696e6720312053554920612064617920616e642065766572796f6e65206765747320612066616972206c61756e63682e0a484153425520436f6d6d756e6974792077696c6c206265206b696e67202e202e202e2057454c434f4d45202048414249424920212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hasbu2_7ff6de86db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

