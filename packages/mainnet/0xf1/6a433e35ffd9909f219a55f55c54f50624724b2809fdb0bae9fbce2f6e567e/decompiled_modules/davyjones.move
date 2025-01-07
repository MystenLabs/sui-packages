module 0xf16a433e35ffd9909f219a55f55c54f50624724b2809fdb0bae9fbce2f6e567e::davyjones {
    struct DAVYJONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVYJONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVYJONES>(arg0, 6, b"DavyJones", b"Captain Davy Jones", b"Captain Davy Jones sets sail on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_e_eb279fb233.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVYJONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAVYJONES>>(v1);
    }

    // decompiled from Move bytecode v6
}

