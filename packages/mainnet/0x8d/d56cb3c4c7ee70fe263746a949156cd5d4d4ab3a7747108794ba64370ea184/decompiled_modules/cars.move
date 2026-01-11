module 0x8dd56cb3c4c7ee70fe263746a949156cd5d4d4ab3a7747108794ba64370ea184::cars {
    struct HeBoomanator has drop {
        dummy_field: bool,
    }

    struct SuipremeSupra has drop {
        dummy_field: bool,
    }

    struct GoldenToiletGT has drop {
        dummy_field: bool,
    }

    struct FordFMBP1974 has drop {
        dummy_field: bool,
    }

    struct SuiverseRegera has drop {
        dummy_field: bool,
    }

    struct AquaGTR has drop {
        dummy_field: bool,
    }

    struct SkelSuiEnergyGT25 has drop {
        dummy_field: bool,
    }

    struct MercedesBuildersG550 has drop {
        dummy_field: bool,
    }

    struct ArkLiveCyberVenture has drop {
        dummy_field: bool,
    }

    struct AstonManni has drop {
        dummy_field: bool,
    }

    struct Juggernaut has drop {
        dummy_field: bool,
    }

    struct NightViper has drop {
        dummy_field: bool,
    }

    struct BlazeHowler has drop {
        dummy_field: bool,
    }

    struct CrimsonPhantom has drop {
        dummy_field: bool,
    }

    struct IronNomad has drop {
        dummy_field: bool,
    }

    struct NeonFang has drop {
        dummy_field: bool,
    }

    struct RedlineReaper has drop {
        dummy_field: bool,
    }

    struct BlueRupture has drop {
        dummy_field: bool,
    }

    struct VenomCircuit has drop {
        dummy_field: bool,
    }

    struct UltraPulse has drop {
        dummy_field: bool,
    }

    struct ScarletDominion has drop {
        dummy_field: bool,
    }

    struct SolarDrift has drop {
        dummy_field: bool,
    }

    struct AzureStrike has drop {
        dummy_field: bool,
    }

    struct BloodApex has drop {
        dummy_field: bool,
    }

    struct VelocityWarden has drop {
        dummy_field: bool,
    }

    struct ToxicSurge has drop {
        dummy_field: bool,
    }

    struct GoldenRevenant has drop {
        dummy_field: bool,
    }

    struct MidnightBrawler has drop {
        dummy_field: bool,
    }

    struct PhantomVector has drop {
        dummy_field: bool,
    }

    struct EmeraldHavoc has drop {
        dummy_field: bool,
    }

    struct HyperDune has drop {
        dummy_field: bool,
    }

    struct BlastFun has drop {
        dummy_field: bool,
    }

    struct Car<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    struct Supply<phantom T0> has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        minted: u64,
    }

    public fun create_supply<T0>(arg0: &0x8dd56cb3c4c7ee70fe263746a949156cd5d4d4ab3a7747108794ba64370ea184::cap::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        let v0 = Supply<T0>{
            id         : 0x2::object::new(arg2),
            max_supply : arg1,
            minted     : 0,
        };
        0x2::transfer::public_transfer<Supply<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_max_supply<T0>(arg0: &Supply<T0>) : u64 {
        arg0.max_supply
    }

    public fun get_minted_count<T0>(arg0: &Supply<T0>) : u64 {
        arg0.minted
    }

    public fun get_supply_info<T0>(arg0: &Supply<T0>) : (u64, u64) {
        (arg0.minted, arg0.max_supply)
    }

    public fun mint_and_transfer<T0>(arg0: &0x8dd56cb3c4c7ee70fe263746a949156cd5d4d4ab3a7747108794ba64370ea184::cap::AdminCap, arg1: &mut Supply<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.minted < arg1.max_supply, 0);
        arg1.minted = arg1.minted + 1;
        let v0 = Car<T0>{
            id          : 0x2::object::new(arg3),
            mint_number : arg1.minted,
        };
        0x2::transfer::public_transfer<Car<T0>>(v0, arg2);
    }

    public fun mint_number<T0>(arg0: &Car<T0>) : u64 {
        arg0.mint_number
    }

    public fun update_supply<T0>(arg0: &0x8dd56cb3c4c7ee70fe263746a949156cd5d4d4ab3a7747108794ba64370ea184::cap::AdminCap, arg1: &mut Supply<T0>, arg2: u64) {
        assert!(arg2 >= arg1.minted, 1);
        arg1.max_supply = arg2;
    }

    // decompiled from Move bytecode v6
}

