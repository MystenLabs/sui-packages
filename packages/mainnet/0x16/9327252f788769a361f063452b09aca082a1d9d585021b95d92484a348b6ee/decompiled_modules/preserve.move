module 0x169327252f788769a361f063452b09aca082a1d9d585021b95d92484a348b6ee::preserve {
    struct PRESERVE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct PreserveConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        active_minter: address,
    }

    struct PreservedTrack has store, key {
        id: 0x2::object::UID,
        track_id: 0x1::string::String,
        title: 0x1::string::String,
        licensee: 0x1::string::String,
        license_type: 0x1::string::String,
        cover_url: 0x1::string::String,
        seal_url: 0x1::string::String,
        mp3_ref: 0x1::string::String,
        preview_ref: 0x1::string::String,
        wav_ref: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        privacy: u8,
        content_hash: vector<u8>,
        audio_hash: vector<u8>,
        issued_at: u64,
        issuer: address,
        expiry_epoch: u64,
        schema_version: u16,
    }

    public fun active_minter(arg0: &PreserveConfig) : address {
        arg0.active_minter
    }

    public fun audio_hash(arg0: &PreservedTrack) : vector<u8> {
        arg0.audio_hash
    }

    public fun expiry_epoch(arg0: &PreservedTrack) : u64 {
        arg0.expiry_epoch
    }

    fun init(arg0: PRESERVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PRESERVE>(arg0, arg1);
        let v1 = 0x2::display::new<PreservedTrack>(&v0, arg1);
        0x2::display::add<PreservedTrack>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(x"4869745a4552c398204365727469666963617465"));
        0x2::display::add<PreservedTrack>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"437265617465642077697468204869745a4552c39820536f6e696320496e74656c6c6967656e63652041492e20416e206f726967696e616c206372656174696f6e2c206c6963656e736564206578636c75736976656c7920746f20796f752e205665726966696564206f6e205375692e"));
        0x2::display::add<PreservedTrack>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{cover_url}"));
        0x2::display::add<PreservedTrack>(&mut v1, 0x1::string::utf8(b"seal_url"), 0x1::string::utf8(b"{seal_url}"));
        0x2::display::add<PreservedTrack>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://hitzero.com/verify?id={track_id}"));
        0x2::display::add<PreservedTrack>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://hitzero.com"));
        0x2::display::add<PreservedTrack>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{licensee}"));
        0x2::display::update_version<PreservedTrack>(&mut v1);
        let v2 = PreserveConfig{
            id            : 0x2::object::new(arg1),
            paused        : false,
            active_minter : @0x0,
        };
        0x2::transfer::share_object<PreserveConfig>(v2);
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v3);
        0x2::transfer::public_transfer<0x2::display::Display<PreservedTrack>>(v1, v3);
    }

    public fun is_paused(arg0: &PreserveConfig) : bool {
        arg0.paused
    }

    public fun issue_minter(arg0: &AdminCap, arg1: &mut PreserveConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.active_minter = arg2;
        let v0 = MinterCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<MinterCap>(v0, arg2);
    }

    public fun mint(arg0: &MinterCap, arg1: &PreserveConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u8, arg13: vector<u8>, arg14: vector<u8>, arg15: u64, arg16: u64, arg17: address, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 3);
        assert!(arg1.active_minter == 0x2::tx_context::sender(arg18), 2);
        assert!(arg12 == 0 || arg12 == 1, 1);
        let v0 = PreservedTrack{
            id             : 0x2::object::new(arg18),
            track_id       : arg2,
            title          : arg3,
            licensee       : arg4,
            license_type   : arg5,
            cover_url      : arg6,
            seal_url       : arg7,
            mp3_ref        : arg8,
            preview_ref    : arg9,
            wav_ref        : arg10,
            seal_policy_id : arg11,
            privacy        : arg12,
            content_hash   : arg13,
            audio_hash     : arg14,
            issued_at      : arg15,
            issuer         : 0x2::tx_context::sender(arg18),
            expiry_epoch   : arg16,
            schema_version : 2,
        };
        0x2::transfer::public_transfer<PreservedTrack>(v0, arg17);
    }

    public fun preview_ref(arg0: &PreservedTrack) : 0x1::string::String {
        arg0.preview_ref
    }

    public fun privacy(arg0: &PreservedTrack) : u8 {
        arg0.privacy
    }

    public fun privacy_private() : u8 {
        0
    }

    public fun privacy_public() : u8 {
        1
    }

    public fun revoke_minter(arg0: &AdminCap, arg1: &mut PreserveConfig) {
        arg1.active_minter = @0x0;
    }

    public fun set_expiry_epoch(arg0: &mut PreservedTrack, arg1: u64) {
        arg0.expiry_epoch = arg1;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut PreserveConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_privacy(arg0: &mut PreservedTrack, arg1: u8) {
        assert!(arg1 == 0 || arg1 == 1, 1);
        arg0.privacy = arg1;
    }

    public fun set_seal_policy(arg0: &mut PreservedTrack, arg1: 0x1::string::String) {
        arg0.seal_policy_id = arg1;
    }

    public fun set_wav_ref(arg0: &mut PreservedTrack, arg1: 0x1::string::String) {
        arg0.wav_ref = arg1;
    }

    public fun track_id(arg0: &PreservedTrack) : 0x1::string::String {
        arg0.track_id
    }

    // decompiled from Move bytecode v6
}

