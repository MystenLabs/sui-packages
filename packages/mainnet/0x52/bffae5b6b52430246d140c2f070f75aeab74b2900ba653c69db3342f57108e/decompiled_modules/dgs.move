module 0x52bffae5b6b52430246d140c2f070f75aeab74b2900ba653c69db3342f57108e::dgs {
    struct DGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGS>(arg0, 6, b"DGS", b"DoggySui", x"446f67677920205355490a0a323032342024446f6767795375692054484520424c4f434b434841494e20444f474759204f4e205355492e2e2e204973206e6f772074616b656e206f76657220627920612043544f205465616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shaggy_head_c8283e70bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

