module 0xf511b015162a941610feb55fe0c418b0411a070a4a04ae32d6f56b6107b71939::bobz {
    struct BOBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBZ>(arg0, 6, b"BOBZ", b"BOBZILLA", b"Bobzilla from Mrcrypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpt6u7qvvg2wftmtjx7facchhzllqs5gyj34xr3x5odduwu5anii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOBZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

