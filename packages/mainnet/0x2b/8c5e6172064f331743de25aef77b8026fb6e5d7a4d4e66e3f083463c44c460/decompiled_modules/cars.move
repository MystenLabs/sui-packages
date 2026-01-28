module 0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars {
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
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        mint_number: u64,
        rim: 0x1::string::String,
        texture: 0x1::string::String,
        speed: u8,
        brake: u8,
        control: u8,
    }

    struct Supply<phantom T0> has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        minted: u64,
    }

    public fun create_supply<T0>(arg0: &0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cap::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        let v0 = Supply<T0>{
            id         : 0x2::object::new(arg2),
            max_supply : arg1,
            minted     : 0,
        };
        0x2::transfer::public_transfer<Supply<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_brake<T0>(arg0: &Car<T0>) : u8 {
        arg0.brake
    }

    public fun get_control<T0>(arg0: &Car<T0>) : u8 {
        arg0.control
    }

    public fun get_image_url<T0>(arg0: &Car<T0>) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_max_supply<T0>(arg0: &Supply<T0>) : u64 {
        arg0.max_supply
    }

    public fun get_minted_count<T0>(arg0: &Supply<T0>) : u64 {
        arg0.minted
    }

    public fun get_name<T0>(arg0: &Car<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_project_url<T0>(arg0: &Car<T0>) : 0x1::string::String {
        arg0.project_url
    }

    public fun get_rim<T0>(arg0: &Car<T0>) : 0x1::string::String {
        arg0.rim
    }

    public fun get_speed<T0>(arg0: &Car<T0>) : u8 {
        arg0.speed
    }

    public fun get_supply_info<T0>(arg0: &Supply<T0>) : (u64, u64) {
        (arg0.minted, arg0.max_supply)
    }

    public fun get_texture<T0>(arg0: &Car<T0>) : 0x1::string::String {
        arg0.texture
    }

    public fun mint_and_transfer<T0>(arg0: &0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cap::AdminCap, arg1: &mut Supply<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: u8, arg9: u8, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.minted < arg1.max_supply, 0);
        assert!(arg7 >= 1 && arg7 <= 10, 2);
        assert!(arg8 >= 1 && arg8 <= 10, 2);
        assert!(arg9 >= 1 && arg9 <= 10, 2);
        arg1.minted = arg1.minted + 1;
        let v0 = Car<T0>{
            id          : 0x2::object::new(arg11),
            name        : arg2,
            image_url   : arg3,
            project_url : arg4,
            mint_number : arg1.minted,
            rim         : arg5,
            texture     : arg6,
            speed       : arg7,
            brake       : arg8,
            control     : arg9,
        };
        0x2::transfer::public_transfer<Car<T0>>(v0, arg10);
    }

    public fun mint_number<T0>(arg0: &Car<T0>) : u64 {
        arg0.mint_number
    }

    public fun update_car<T0>(arg0: &mut Car<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u8, arg8: u8) {
        assert!(arg6 >= 1 && arg6 <= 10, 2);
        assert!(arg7 >= 1 && arg7 <= 10, 2);
        assert!(arg8 >= 1 && arg8 <= 10, 2);
        arg0.name = arg1;
        arg0.image_url = arg2;
        arg0.project_url = arg3;
        arg0.rim = arg4;
        arg0.texture = arg5;
        arg0.speed = arg6;
        arg0.brake = arg7;
        arg0.control = arg8;
    }

    public fun update_supply<T0>(arg0: &0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cap::AdminCap, arg1: &mut Supply<T0>, arg2: u64) {
        assert!(arg2 >= arg1.minted, 1);
        arg1.max_supply = arg2;
    }

    // decompiled from Move bytecode v6
}

