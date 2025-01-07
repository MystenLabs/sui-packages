module 0xaac03e7b3950f8fcb42f273ce6fc82d15e04a010b354fedbce454df7259cb729::ligma {
    struct LIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGMA>(arg0, 6, b"Ligma", b"LIGMA SUI", b"HE LIGMA RETARDED ARMY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_18_03_39_5643c714ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

