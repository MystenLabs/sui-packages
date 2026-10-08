module 0x9f4f5d782cf376315ca24a5173fcc9f7b620e8fb44ad6e49e035e710d2218735::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"08464f5552434154530d466f75722043617473205375699301342043415453202824464f555243415453290a0a4d6565742024464f5552434154532e0a0a466f7572206b697474656e732c206f6e6520756e73746f707061626c65206d656d652e0a0a54686520342b2048617262696e20627572737420697320686572652c203434343420656e657267792c2070757265206368616f732c20616e64206d656d6520706f74656e7469616c2e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f37643935343837663963323537376630336138326338633165343838663538642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

