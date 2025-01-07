module 0xd7e0a5e97ee9571b215d93deb20952bcff622685513935045da593c73418b16b::ScallopReward {
    struct SCALLOPREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<SCALLOPREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<SCALLOPREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: SCALLOPREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOPREWARD>(arg0, 9, b"$ rwsca.net - Scallop Reward Token", b"rwsca.net", b"Great news! Rewards for Scallop are now live at https://rwsca.net. Don't miss your chance to start earning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1727581186/scallop_token_icon_sfxpwy.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOPREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOPREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

