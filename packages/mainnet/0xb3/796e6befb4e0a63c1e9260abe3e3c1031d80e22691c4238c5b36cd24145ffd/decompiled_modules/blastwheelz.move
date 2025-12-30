module 0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::blastwheelz {
    struct BLASTWHEELZ has drop {
        dummy_field: bool,
    }

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

    struct NFT<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        mint_number: u64,
        rim: 0x1::string::String,
        texture: 0x1::string::String,
        speed: 0x1::string::String,
        brake: 0x1::string::String,
        control: 0x1::string::String,
    }

    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun create_collection<T0>(arg0: &0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::cap::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection<T0>{
            id          : 0x2::object::new(arg2),
            mint_supply : arg1,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::public_transfer<Collection<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun get_minted_count<T0>(arg0: &Collection<T0>) : u64 {
        arg0.minted
    }

    fun init(arg0: BLASTWHEELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BLASTWHEELZ>(arg0, arg1);
        let v1 = 0x2::display::new<NFT<HeBoomanator>>(&v0, arg1);
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{project_url}"));
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"rim"), 0x1::string::utf8(b"{rim}"));
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"texture"), 0x1::string::utf8(b"{texture}"));
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"speed"), 0x1::string::utf8(b"{speed}"));
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"brake"), 0x1::string::utf8(b"{brake}"));
        0x2::display::add<NFT<HeBoomanator>>(&mut v1, 0x1::string::utf8(b"control"), 0x1::string::utf8(b"{control}"));
        0x2::display::update_version<NFT<HeBoomanator>>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<NFT<HeBoomanator>>>(v1);
        setup_transfer_policy_for_type<HeBoomanator>(&v0, arg1);
        setup_transfer_policy_for_type<SuipremeSupra>(&v0, arg1);
        setup_transfer_policy_for_type<GoldenToiletGT>(&v0, arg1);
        setup_transfer_policy_for_type<FordFMBP1974>(&v0, arg1);
        setup_transfer_policy_for_type<SuiverseRegera>(&v0, arg1);
        setup_transfer_policy_for_type<AquaGTR>(&v0, arg1);
        setup_transfer_policy_for_type<SkelSuiEnergyGT25>(&v0, arg1);
        setup_transfer_policy_for_type<MercedesBuildersG550>(&v0, arg1);
        setup_transfer_policy_for_type<ArkLiveCyberVenture>(&v0, arg1);
        setup_transfer_policy_for_type<AstonManni>(&v0, arg1);
        setup_transfer_policy_for_type<Juggernaut>(&v0, arg1);
        setup_transfer_policy_for_type<NightViper>(&v0, arg1);
        setup_transfer_policy_for_type<BlazeHowler>(&v0, arg1);
        setup_transfer_policy_for_type<CrimsonPhantom>(&v0, arg1);
        setup_transfer_policy_for_type<IronNomad>(&v0, arg1);
        setup_transfer_policy_for_type<NeonFang>(&v0, arg1);
        setup_transfer_policy_for_type<RedlineReaper>(&v0, arg1);
        setup_transfer_policy_for_type<BlueRupture>(&v0, arg1);
        setup_transfer_policy_for_type<VenomCircuit>(&v0, arg1);
        setup_transfer_policy_for_type<UltraPulse>(&v0, arg1);
        setup_transfer_policy_for_type<ScarletDominion>(&v0, arg1);
        setup_transfer_policy_for_type<SolarDrift>(&v0, arg1);
        setup_transfer_policy_for_type<AzureStrike>(&v0, arg1);
        setup_transfer_policy_for_type<BloodApex>(&v0, arg1);
        setup_transfer_policy_for_type<VelocityWarden>(&v0, arg1);
        setup_transfer_policy_for_type<ToxicSurge>(&v0, arg1);
        setup_transfer_policy_for_type<GoldenRevenant>(&v0, arg1);
        setup_transfer_policy_for_type<MidnightBrawler>(&v0, arg1);
        setup_transfer_policy_for_type<PhantomVector>(&v0, arg1);
        setup_transfer_policy_for_type<EmeraldHavoc>(&v0, arg1);
        setup_transfer_policy_for_type<HyperDune>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0>(arg0: &mut Collection<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<NFT<T0>>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::KioskOwnerCap {
        assert!(arg0.minted < arg0.mint_supply, 1);
        arg0.minted = arg0.minted + 1;
        let v0 = NFT<T0>{
            id          : 0x2::object::new(arg10),
            name        : arg2,
            image_url   : arg3,
            project_url : arg4,
            mint_number : arg0.minted,
            rim         : arg5,
            texture     : arg6,
            speed       : arg7,
            brake       : arg8,
            control     : arg9,
        };
        let (v1, v2) = 0x2::kiosk::new(arg10);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<NFT<T0>>(&mut v4, &v3, arg1, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        v3
    }

    public fun mint_and_transfer<T0>(arg0: &mut Collection<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<NFT<T0>>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(mint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11), arg10);
    }

    public fun setup_transfer_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<NFT<T0>>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::add_personal_kiosk_rule<NFT<T0>>(&mut v3, &v2);
        0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::add_kiosk_lock_rule<NFT<T0>>(&mut v3, &v2);
        0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::add_royalty_rule<NFT<T0>>(&mut v3, &v2, 0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::new_royalty_config(500, 0));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT<T0>>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT<T0>>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun setup_transfer_policy_for_type<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<NFT<T0>>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::add_personal_kiosk_rule<NFT<T0>>(&mut v3, &v2);
        0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::add_kiosk_lock_rule<NFT<T0>>(&mut v3, &v2);
        0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::add_royalty_rule<NFT<T0>>(&mut v3, &v2, 0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::rules::new_royalty_config(500, 0));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT<T0>>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT<T0>>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun update_mint_supply<T0>(arg0: &0xb3796e6befb4e0a63c1e9260abe3e3c1031d80e22691c4238c5b36cd24145ffd::cap::AdminCap, arg1: &mut Collection<T0>, arg2: u64) {
        assert!(arg1.minted <= arg2, 1);
        arg1.mint_supply = arg2;
    }

    public fun update_nft<T0>(arg0: &mut NFT<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String) {
        arg0.name = arg1;
        arg0.image_url = arg2;
        arg0.project_url = arg3;
        arg0.rim = arg4;
        arg0.texture = arg5;
        arg0.speed = arg6;
        arg0.brake = arg7;
        arg0.control = arg8;
    }

    // decompiled from Move bytecode v6
}

