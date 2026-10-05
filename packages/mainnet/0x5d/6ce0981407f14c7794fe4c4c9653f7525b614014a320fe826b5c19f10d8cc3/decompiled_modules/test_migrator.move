module 0x5d6ce0981407f14c7794fe4c4c9653f7525b614014a320fe826b5c19f10d8cc3::test_migrator {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun migrate<T0, T1>(arg0: &mut 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::Presale<T0, T1>, arg1: &0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::fee_policy::FeePolicy, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::migrate<T0, T1, Witness>(arg0, arg1, v0, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg4), arg2);
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: u64, arg3: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg4: 0x1::option::Option<0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::VestingTerms>, arg5: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg6: vector<0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::RecipientShare>, arg7: bool, arg8: u64, arg9: vector<0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::RecipientShare>, arg10: u64, arg11: u64, arg12: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::EligibilityPolicy, arg13: 0x1::option::Option<0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::UncappedPhase>, arg14: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::FeeSplit, arg15: &0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::creation_policy::CreationPolicy, arg16: &0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::fee_policy::FeePolicy, arg17: &mut 0x2::tx_context::TxContext) : (0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::Presale<T0, T1>, 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::PresaleCap) {
        let v0 = Witness{dummy_field: false};
        0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale::new<T0, T1, Witness>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v0, 200, 10000, arg14, arg15, arg16, arg17)
    }

    // decompiled from Move bytecode v7
}

