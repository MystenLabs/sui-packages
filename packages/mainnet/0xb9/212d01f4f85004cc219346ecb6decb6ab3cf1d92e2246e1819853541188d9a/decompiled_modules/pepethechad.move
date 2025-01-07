module 0xb9212d01f4f85004cc219346ecb6decb6ab3cf1d92e2246e1819853541188d9a::pepethechad {
    struct PEPETHECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPETHECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETHECHAD>(arg0, 6, b"Pepethechad", b"PEPETHECHADSUI", b"Pepe The Chad is Here! Bigger, stronger, and ready to flex on the crypto world. The ultimate alpha meme evolution has arrived!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zr_ZFP_8_Pq_400x400_7a488b028d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETHECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPETHECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

