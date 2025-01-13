module 0xd180b97162c4c64032189fc2985afcf2f4130800ba68f0a8b1d5cb315ee72898::presuident47 {
    struct PRESUIDENT47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESUIDENT47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESUIDENT47>(arg0, 6, b"PreSUIdent47", b"PreSUIdent Trump", x"42696720426f7373205472756d7020636f6d696e6720746f207361766520746865206d61726b65742e0a5765206e6565642068696d20415341502e204c6574732073656e64207468697320666f72207468652063756c74757265210a50726573756964656e74205452554d5020746f204d414b4520414d455249434120475245415420414741494e2e0a2f52554e5f49540a2f53454e445f4954", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trump_optimizado_371255ccab.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESUIDENT47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRESUIDENT47>>(v1);
    }

    // decompiled from Move bytecode v6
}

