module 0x4d4fee12a168c4cc276a0a22996f97d99cfd620bbe4b0118aee38c682bd33fde::vpc {
    struct VPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VPC>(arg0, 6, b"VPC", b"Void Panda Coin", b"Void panda is for those wo believe wealth comes to those who chill,. Whatever, win anyway - because sometimes the void gives back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023964_c9b66e80e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

