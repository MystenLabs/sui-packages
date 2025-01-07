module 0x7b59a4a158bb72cca923b3eeb02c83b879f6d413c906f310099432d48c6ce803::ligma {
    struct LIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGMA>(arg0, 6, b"LIGMA", b"LIGMASUI", b"Ligma Males on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_21_23_12_removebg_preview_ba5973dd54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

