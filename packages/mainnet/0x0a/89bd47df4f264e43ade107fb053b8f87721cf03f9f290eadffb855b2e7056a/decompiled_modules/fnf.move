module 0xa89bd47df4f264e43ade107fb053b8f87721cf03f9f290eadffb855b2e7056a::fnf {
    struct FNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNF>(arg0, 6, b"FNF", b"Fait & Freedom", b"NEW Official Trump Meme is HERE! Its time to celebrate everything we stand for: WINNING! Join my very special Trump Community. GET YOUR $FNF NOW. Have Fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026962_1a16308918.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FNF>>(v1);
    }

    // decompiled from Move bytecode v6
}

