module 0x74af809c37cf6ef44fa0cf6a635a6cfa2405e9d6678b59f572c4cf6087f1658f::NYRO {
    struct NYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYRO>(arg0, 9, b"NYRO", b"SUI NYRO", b"Nyro, the vibrant memecoin of SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1750079018681143296/mF__SVRh_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NYRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NYRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

