module 0xe4fcf2415fbfe82580ef06c83a9e70552007194c08aa380521a6967229a9fe9f::rahrah {
    struct RAHRAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAHRAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAHRAH>(arg0, 9, b"RAHRAH", b"Rahma", b"AI integration token for multiplatform adoption ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46b4b85f-1739-46a5-9918-3dc55036bc4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAHRAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAHRAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

