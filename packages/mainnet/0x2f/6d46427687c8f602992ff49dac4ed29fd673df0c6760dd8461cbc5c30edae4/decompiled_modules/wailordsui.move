module 0x2f6d46427687c8f602992ff49dac4ed29fd673df0c6760dd8461cbc5c30edae4::wailordsui {
    struct WAILORDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAILORDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAILORDSUI>(arg0, 6, b"WailordSui", b"WAILORD  SUI", b"WAILORD ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif2pq6eedrfq7jsfyo3sy4gqfekq5eew55m6qsgy5mt7ipdiizqdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAILORDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAILORDSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

