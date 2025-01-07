module 0x492afdc3b1e8dee22fea5160b92cdefb16cd4f2b5cff473a3bdb814d98d93b9f::elvesui {
    struct ELVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELVESUI>(arg0, 6, b"ELVESUI", b"Elves on SUI", x"20556e6c65617368696e6720686f6c69646179206d61676963202d20796f7520776f6e27742077616e7420746f206d69737320746869732064726f70210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd_TWUVU_Xg_AA_Hx_OW_4175769397.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

