module 0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden {
    struct SquidMaidenAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MF_SQUID_MAIDEN has drop {
        dummy_field: bool,
    }

    struct Metadata has drop, store {
        background: 0x1::string::String,
        eyes: 0x1::string::String,
        mouth: 0x1::string::String,
        hair: 0x1::string::String,
        hat: 0x1::string::String,
        back_item: 0x1::string::String,
        cloth: 0x1::string::String,
        number: u64,
    }

    struct UMetadata has drop, store {
        background: u8,
        eyes: u8,
        mouth: u8,
        hair: u8,
        hat: u8,
        back_item: u8,
        cloth: u8,
        number: u64,
    }

    struct MfSquidMaiden has store, key {
        id: 0x2::object::UID,
        metadata: Metadata,
    }

    struct MfSquidMaidenMinted has copy, drop {
        id: 0x2::object::ID,
    }

    public fun new(arg0: UMetadata, arg1: &mut 0x2::tx_context::TxContext) : MfSquidMaiden {
        let v0 = Metadata{
            background : match_background(&arg0),
            eyes       : match_eyes(&arg0),
            mouth      : match_mouth(&arg0),
            hair       : match_hair(&arg0),
            hat        : match_hat(&arg0),
            back_item  : match_back_item(&arg0),
            cloth      : match_cloth(&arg0),
            number     : arg0.number,
        };
        let v1 = MfSquidMaiden{
            id       : 0x2::object::new(arg1),
            metadata : v0,
        };
        let v2 = MfSquidMaidenMinted{id: 0x2::object::uid_to_inner(&v1.id)};
        0x2::event::emit<MfSquidMaidenMinted>(v2);
        v1
    }

    public fun id(arg0: &MfSquidMaiden) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: MF_SQUID_MAIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SquidMaidenAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SquidMaidenAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<MF_SQUID_MAIDEN>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"eyes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"mouth"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"hair"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"hat"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"back_item"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"cloth"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"MF Squid Maidens #{metadata.number}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"10k bratty waifus who'll coordinate you into submission. Painfully kawaii. Choke me with those tentacles, onii-chan~!"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://images.mfsquid.market/ika-pfp/{metadata.number}.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"dWallet Labs / Rhei / Anima Labs / Studio Mirai"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://mfsmnft.wal.app/"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"MF SQUID MARKET"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.background}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.eyes}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.mouth}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.hair}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.hat}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.back_item}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.cloth}"));
        let v6 = 0x2::display::new_with_fields<MfSquidMaiden>(&v1, v2, v4, arg1);
        0x2::display::update_version<MfSquidMaiden>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<MfSquidMaiden>(&v1, arg1);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<MfSquidMaiden>(&mut v10, &v9, 1380, 1000000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<MfSquidMaiden>(&mut v10, &v9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<MfSquidMaiden>(&mut v10, &v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MfSquidMaiden>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MfSquidMaiden>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MfSquidMaiden>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    fun match_back_item(arg0: &UMetadata) : 0x1::string::String {
        let v0 = arg0.back_item;
        let v1 = &v0;
        if (*v1 == 0) {
            0x1::string::utf8(b"None")
        } else if (*v1 == 1) {
            0x1::string::utf8(b"I like fish")
        } else if (*v1 == 2) {
            0x1::string::utf8(b"I think it's a wand")
        } else if (*v1 == 3) {
            0x1::string::utf8(b"It's a sword")
        } else if (*v1 == 4) {
            0x1::string::utf8(b"It's dirty wings")
        } else if (*v1 == 5) {
            0x1::string::utf8(b"It's two swords")
        } else if (*v1 == 6) {
            0x1::string::utf8(b"It's Wings")
        } else if (*v1 == 7) {
            0x1::string::utf8(b"Spear on Ika")
        } else if (*v1 == 8) {
            0x1::string::utf8(b"The Purrfect Tail")
        } else if (*v1 == 9) {
            0x1::string::utf8(b"Tinker")
        } else if (*v1 == 10) {
            0x1::string::utf8(b"Where's my hammer")
        } else {
            match_unique(arg0.back_item)
        }
    }

    fun match_background(arg0: &UMetadata) : 0x1::string::String {
        let v0 = arg0.background;
        let v1 = &v0;
        if (*v1 == 1) {
            0x1::string::utf8(b"Blue")
        } else if (*v1 == 2) {
            0x1::string::utf8(b"Gold Stars")
        } else if (*v1 == 3) {
            0x1::string::utf8(b"Green")
        } else if (*v1 == 4) {
            0x1::string::utf8(b"Greenish Yellow")
        } else if (*v1 == 5) {
            0x1::string::utf8(b"Hot Springs")
        } else if (*v1 == 6) {
            0x1::string::utf8(b"Lime")
        } else if (*v1 == 7) {
            0x1::string::utf8(b"Magenta")
        } else if (*v1 == 8) {
            0x1::string::utf8(b"Neon City")
        } else if (*v1 == 9) {
            0x1::string::utf8(b"Neon Pink")
        } else if (*v1 == 10) {
            0x1::string::utf8(b"Nightcity")
        } else if (*v1 == 11) {
            0x1::string::utf8(b"Off-White")
        } else if (*v1 == 12) {
            0x1::string::utf8(b"Orange")
        } else if (*v1 == 13) {
            0x1::string::utf8(b"Pink Stars")
        } else if (*v1 == 14) {
            0x1::string::utf8(b"Pink")
        } else if (*v1 == 15) {
            0x1::string::utf8(b"Purple")
        } else if (*v1 == 16) {
            0x1::string::utf8(b"Rainbow")
        } else if (*v1 == 17) {
            0x1::string::utf8(b"Red")
        } else if (*v1 == 18) {
            0x1::string::utf8(b"Sakura Trees")
        } else if (*v1 == 19) {
            0x1::string::utf8(b"Sky Blue")
        } else if (*v1 == 20) {
            0x1::string::utf8(b"Sunset")
        } else if (*v1 == 21) {
            0x1::string::utf8(b"The Squid Market")
        } else if (*v1 == 22) {
            0x1::string::utf8(b"Turqouise")
        } else if (*v1 == 23) {
            0x1::string::utf8(b"Yellow")
        } else {
            match_unique(arg0.background)
        }
    }

    fun match_cloth(arg0: &UMetadata) : 0x1::string::String {
        let v0 = arg0.cloth;
        let v1 = &v0;
        if (*v1 == 1) {
            0x1::string::utf8(b"Bunny Girl Harem")
        } else if (*v1 == 2) {
            0x1::string::utf8(b"By the power of kinks dress")
        } else if (*v1 == 3) {
            0x1::string::utf8(b"Casual Cat Outfit")
        } else if (*v1 == 4) {
            0x1::string::utf8(b"Definitely a Sailor Outfit")
        } else if (*v1 == 5) {
            0x1::string::utf8(b"Does this Really Protect Me Armour")
        } else if (*v1 == 6) {
            0x1::string::utf8(b"Dressed for success Outfit")
        } else if (*v1 == 7) {
            0x1::string::utf8(b"Good for your soul Suit")
        } else if (*v1 == 8) {
            0x1::string::utf8(b"Gud Times Hoodie")
        } else if (*v1 == 9) {
            0x1::string::utf8(b"I Summon Demons Robes")
        } else if (*v1 == 10) {
            0x1::string::utf8(b"IKarate Robes")
        } else if (*v1 == 11) {
            0x1::string::utf8(b"Im on a duck man")
        } else if (*v1 == 12) {
            0x1::string::utf8(b"Its just a Pink Sweater")
        } else if (*v1 == 13) {
            0x1::string::utf8(b"Kimono")
        } else if (*v1 == 14) {
            0x1::string::utf8(b"MF CAT OUTFIT")
        } else if (*v1 == 15) {
            0x1::string::utf8(b"MFSM Hoodie")
        } else if (*v1 == 16) {
            0x1::string::utf8(b"Sexy Shinobi")
        } else if (*v1 == 17) {
            0x1::string::utf8(b"Squidmas Jumper")
        } else if (*v1 == 18) {
            0x1::string::utf8(b"Squids in space")
        } else if (*v1 == 19) {
            0x1::string::utf8(b"Welcome to Brixton")
        } else {
            match_unique(arg0.cloth)
        }
    }

    fun match_eyes(arg0: &UMetadata) : 0x1::string::String {
        let v0 = arg0.eyes;
        let v1 = &v0;
        if (*v1 == 1) {
            0x1::string::utf8(b"Awwwyes")
        } else if (*v1 == 2) {
            0x1::string::utf8(b"Blue eyes white dragon")
        } else if (*v1 == 3) {
            0x1::string::utf8(b"Byakugan")
        } else if (*v1 == 4) {
            0x1::string::utf8(b"Cat eyes")
        } else if (*v1 == 5) {
            0x1::string::utf8(b"Green eyes")
        } else if (*v1 == 6) {
            0x1::string::utf8(b"Heart eyes")
        } else if (*v1 == 7) {
            0x1::string::utf8(b"Heterochromia")
        } else if (*v1 == 8) {
            0x1::string::utf8(b"Hypnotizeyed")
        } else if (*v1 == 9) {
            0x1::string::utf8(b"Ika Gear Solid Squid")
        } else if (*v1 == 10) {
            0x1::string::utf8(b"In need of Visine Eyes")
        } else if (*v1 == 11) {
            0x1::string::utf8(b"Not that interested in what you got to say eyes")
        } else if (*v1 == 12) {
            0x1::string::utf8(b"Red eyes black dragon")
        } else if (*v1 == 13) {
            0x1::string::utf8(b"Star eyes")
        } else if (*v1 == 14) {
            0x1::string::utf8(b"Starry-eyed")
        } else if (*v1 == 15) {
            0x1::string::utf8(b"The two-eyed wink")
        } else if (*v1 == 16) {
            0x1::string::utf8(b"Yennefer's eyes")
        } else {
            match_unique(arg0.eyes)
        }
    }

    fun match_hair(arg0: &UMetadata) : 0x1::string::String {
        let v0 = arg0.hair;
        let v1 = &v0;
        if (*v1 == 1) {
            0x1::string::utf8(b"Between short and medium pink hair")
        } else if (*v1 == 2) {
            0x1::string::utf8(b"Braided pink hair")
        } else if (*v1 == 3) {
            0x1::string::utf8(b"Classic IkA-chan hair")
        } else if (*v1 == 4) {
            0x1::string::utf8(b"Medium length hair")
        } else if (*v1 == 5) {
            0x1::string::utf8(b"Messy ponytail pink hair")
        } else if (*v1 == 6) {
            0x1::string::utf8(b"Pilot hair")
        } else if (*v1 == 7) {
            0x1::string::utf8(b"Pink-haired pigtails")
        } else if (*v1 == 8) {
            0x1::string::utf8(b"Pink-haired ponytail")
        } else if (*v1 == 9) {
            0x1::string::utf8(b"Sad IkA-chan hair")
        } else if (*v1 == 10) {
            0x1::string::utf8(b"Short pink hair")
        } else if (*v1 == 11) {
            0x1::string::utf8(b"Wavy pink hair")
        } else {
            match_unique(arg0.hair)
        }
    }

    fun match_hat(arg0: &UMetadata) : 0x1::string::String {
        let v0 = arg0.hat;
        let v1 = &v0;
        if (*v1 == 0) {
            0x1::string::utf8(b"None")
        } else if (*v1 == 1) {
            0x1::string::utf8(b"Beaten up by Aslan Hat")
        } else if (*v1 == 2) {
            0x1::string::utf8(b"Cat ears")
        } else if (*v1 == 3) {
            0x1::string::utf8(b"Chicken head")
        } else if (*v1 == 4) {
            0x1::string::utf8(b"Cutesy horns")
        } else if (*v1 == 5) {
            0x1::string::utf8(b"Dress for success Hair band")
        } else if (*v1 == 6) {
            0x1::string::utf8(b"Hair bow")
        } else if (*v1 == 7) {
            0x1::string::utf8(b"Halo")
        } else if (*v1 == 8) {
            0x1::string::utf8(b"Hoe-Kage")
        } else if (*v1 == 9) {
            0x1::string::utf8(b"iKasa")
        } else if (*v1 == 10) {
            0x1::string::utf8(b"It's just a hat man")
        } else if (*v1 == 11) {
            0x1::string::utf8(b"Nurse Hat")
        } else if (*v1 == 12) {
            0x1::string::utf8(b"Oni Mask")
        } else if (*v1 == 13) {
            0x1::string::utf8(b"Pretty Princess Tiara")
        } else if (*v1 == 14) {
            0x1::string::utf8(b"Shark head")
        } else if (*v1 == 15) {
            0x1::string::utf8(b"Squid head")
        } else if (*v1 == 16) {
            0x1::string::utf8(b"You're a wizard Hatty")
        } else {
            match_unique(arg0.hat)
        }
    }

    fun match_mouth(arg0: &UMetadata) : 0x1::string::String {
        let v0 = arg0.mouth;
        let v1 = &v0;
        if (*v1 == 1) {
            0x1::string::utf8(b":|")
        } else if (*v1 == 2) {
            0x1::string::utf8(b":o")
        } else if (*v1 == 3) {
            0x1::string::utf8(b":p")
        } else if (*v1 == 4) {
            0x1::string::utf8(b"Bubble")
        } else if (*v1 == 5) {
            0x1::string::utf8(b"Cat Tooth")
        } else if (*v1 == 6) {
            0x1::string::utf8(b"Classic Smile")
        } else if (*v1 == 7) {
            0x1::string::utf8(b"closed mouth")
        } else if (*v1 == 8) {
            0x1::string::utf8(b"Drool")
        } else if (*v1 == 9) {
            0x1::string::utf8(b"excited mouth")
        } else if (*v1 == 10) {
            0x1::string::utf8(b"facemask")
        } else if (*v1 == 11) {
            0x1::string::utf8(b"Grr")
        } else if (*v1 == 12) {
            0x1::string::utf8(b"Kissy Kiss")
        } else if (*v1 == 13) {
            0x1::string::utf8(b"Lolipop")
        } else if (*v1 == 14) {
            0x1::string::utf8(b"Luscious lips")
        } else if (*v1 == 15) {
            0x1::string::utf8(b"Meow Meow")
        } else if (*v1 == 16) {
            0x1::string::utf8(b"Open Mouth")
        } else if (*v1 == 17) {
            0x1::string::utf8(b"Pissed TFO")
        } else if (*v1 == 18) {
            0x1::string::utf8(b"sadge")
        } else if (*v1 == 19) {
            0x1::string::utf8(b"Urhm")
        } else {
            match_unique(arg0.mouth)
        }
    }

    fun match_unique(arg0: u8) : 0x1::string::String {
        let v0 = &arg0;
        if (*v0 == 100) {
            0x1::string::utf8(b"Robot Chan")
        } else if (*v0 == 101) {
            0x1::string::utf8(b"Bocchi Chan")
        } else if (*v0 == 102) {
            0x1::string::utf8(b"Diamond Chan")
        } else if (*v0 == 103) {
            0x1::string::utf8(b"Kostas Pet Chan")
        } else if (*v0 == 104) {
            0x1::string::utf8(b"Blub Chan")
        } else if (*v0 == 105) {
            0x1::string::utf8(b"Sui Chan")
        } else if (*v0 == 106) {
            0x1::string::utf8(b"Halftone Chan")
        } else if (*v0 == 107) {
            0x1::string::utf8(b"Otaku Chan")
        } else if (*v0 == 108) {
            0x1::string::utf8(b"Kawaii Chan")
        } else if (*v0 == 109) {
            0x1::string::utf8(b"Sam Chan")
        } else if (*v0 == 110) {
            0x1::string::utf8(b"Pillow Chan")
        } else if (*v0 == 111) {
            0x1::string::utf8(b"Nami Chan")
        } else if (*v0 == 112) {
            0x1::string::utf8(b"Zen AF Chan")
        } else if (*v0 == 113) {
            0x1::string::utf8(b"Itachi Chan")
        } else if (*v0 == 114) {
            0x1::string::utf8(b"Jurassic Chan")
        } else if (*v0 == 115) {
            0x1::string::utf8(b"Evan Chan")
        } else if (*v0 == 116) {
            0x1::string::utf8(b"Sherlock Chan")
        } else if (*v0 == 117) {
            0x1::string::utf8(b"Georgie Chan")
        } else if (*v0 == 118) {
            0x1::string::utf8(b"Chef Chan")
        } else if (*v0 == 119) {
            0x1::string::utf8(b"Alcina Chan")
        } else if (*v0 == 120) {
            0x1::string::utf8(b"Cthulhu Chan")
        } else if (*v0 == 121) {
            0x1::string::utf8(b"Bitcoin Chan")
        } else if (*v0 == 122) {
            0x1::string::utf8(b"The Order Chan")
        } else if (*v0 == 123) {
            0x1::string::utf8(b"Wara Chan")
        } else if (*v0 == 124) {
            0x1::string::utf8(b"Suiyan Chan")
        } else if (*v0 == 125) {
            0x1::string::utf8(b"Madoka Chan")
        } else if (*v0 == 126) {
            0x1::string::utf8(b"Martian Chan")
        } else if (*v0 == 127) {
            0x1::string::utf8(b"Ripple Chan")
        } else if (*v0 == 128) {
            0x1::string::utf8(b"Bunny Girl Chan")
        } else if (*v0 == 129) {
            0x1::string::utf8(b"Queenie Chan")
        } else if (*v0 == 130) {
            0x1::string::utf8(b"Speed Wagon Chan")
        } else if (*v0 == 131) {
            0x1::string::utf8(b"Anya Chan")
        } else if (*v0 == 132) {
            0x1::string::utf8(b"Nurse Chan")
        } else if (*v0 == 133) {
            0x1::string::utf8(b"Habibi Chan")
        } else if (*v0 == 134) {
            0x1::string::utf8(b"jiangshi Chan")
        } else if (*v0 == 135) {
            0x1::string::utf8(b"Squid Chan")
        } else if (*v0 == 136) {
            0x1::string::utf8(b"Pulpy Chan")
        } else if (*v0 == 137) {
            0x1::string::utf8(b"Mermaid Chan")
        } else if (*v0 == 138) {
            0x1::string::utf8(b"Kamo Chan")
        } else if (*v0 == 139) {
            0x1::string::utf8(b"Goldie Chan")
        } else if (*v0 == 140) {
            0x1::string::utf8(b"Knight Chan")
        } else if (*v0 == 141) {
            0x1::string::utf8(b"Chika Chan")
        } else if (*v0 == 142) {
            0x1::string::utf8(b"Stewardess Chan")
        } else if (*v0 == 143) {
            0x1::string::utf8(b"Shinigami Chan")
        } else if (*v0 == 144) {
            0x1::string::utf8(b"Padawan Chan")
        } else if (*v0 == 145) {
            0x1::string::utf8(b"Violet Chan")
        } else if (*v0 == 146) {
            0x1::string::utf8(b"UwU Chan")
        } else if (*v0 == 147) {
            0x1::string::utf8(b"Geisha Chan")
        } else if (*v0 == 148) {
            0x1::string::utf8(b"Legacy Chan")
        } else if (*v0 == 149) {
            0x1::string::utf8(b"Gundam Chan")
        } else if (*v0 == 150) {
            0x1::string::utf8(b"Tornado Chan")
        } else if (*v0 == 151) {
            0x1::string::utf8(b"Zen Chan")
        } else if (*v0 == 152) {
            0x1::string::utf8(b"Axol Chan")
        } else if (*v0 == 153) {
            0x1::string::utf8(b"Matrix Chan")
        } else if (*v0 == 154) {
            0x1::string::utf8(b"O-onii Chan")
        } else if (*v0 == 155) {
            0x1::string::utf8(b"Skele Chan")
        } else if (*v0 == 156) {
            0x1::string::utf8(b"Holy Chan")
        } else if (*v0 == 157) {
            0x1::string::utf8(b"Lofi Chan")
        } else if (*v0 == 158) {
            0x1::string::utf8(b"Walrus Chan")
        } else if (*v0 == 159) {
            0x1::string::utf8(b"Doll Chan")
        } else if (*v0 == 160) {
            0x1::string::utf8(b"Eth Chan")
        } else if (*v0 == 161) {
            0x1::string::utf8(b"Maid chan")
        } else if (*v0 == 162) {
            0x1::string::utf8(b"Medusa Chan")
        } else if (*v0 == 163) {
            0x1::string::utf8(b"Aftermath Chan")
        } else if (*v0 == 164) {
            0x1::string::utf8(b"Biker Chan")
        } else if (*v0 == 165) {
            0x1::string::utf8(b"Explorer Chan")
        } else if (*v0 == 166) {
            0x1::string::utf8(b"Adeniyi Chan")
        } else if (*v0 == 167) {
            0x1::string::utf8(b"Kani Chan")
        } else if (*v0 == 168) {
            0x1::string::utf8(b"Same Chan")
        } else if (*v0 == 169) {
            0x1::string::utf8(b"Vampire Chan")
        } else if (*v0 == 170) {
            0x1::string::utf8(b"Issei Chan")
        } else if (*v0 == 171) {
            0x1::string::utf8(b"Cubist Chan")
        } else if (*v0 == 172) {
            0x1::string::utf8(b"Ripley Chan")
        } else if (*v0 == 173) {
            0x1::string::utf8(b"Sailor Chan")
        } else if (*v0 == 174) {
            0x1::string::utf8(b"cherry blossom chan")
        } else if (*v0 == 175) {
            0x1::string::utf8(b"MFSM Chan")
        } else if (*v0 == 176) {
            0x1::string::utf8(b"Comic chan")
        } else if (*v0 == 177) {
            0x1::string::utf8(b"Pawtato Land Chan")
        } else if (*v0 == 178) {
            0x1::string::utf8(b"Builder Chan")
        } else if (*v0 == 179) {
            0x1::string::utf8(b"fugu chan")
        } else if (*v0 == 180) {
            0x1::string::utf8(b"Ronin Chan")
        } else if (*v0 == 181) {
            0x1::string::utf8(b"Sakura Chan")
        } else if (*v0 == 182) {
            0x1::string::utf8(b"Quantum Chan")
        } else if (*v0 == 183) {
            0x1::string::utf8(b"Spooky Chan")
        } else if (*v0 == 184) {
            0x1::string::utf8(b"Breaking News Chan")
        } else if (*v0 == 185) {
            0x1::string::utf8(b"Double Up Chan")
        } else if (*v0 == 186) {
            0x1::string::utf8(b"Cat Girl Chan")
        } else if (*v0 == 187) {
            0x1::string::utf8(b"Sega Chan")
        } else if (*v0 == 188) {
            0x1::string::utf8(b"Astro Chan")
        } else if (*v0 == 189) {
            0x1::string::utf8(b"Electro Chan")
        } else if (*v0 == 190) {
            0x1::string::utf8(b"puggies chan")
        } else if (*v0 == 191) {
            0x1::string::utf8(b"Kostas Chan")
        } else if (*v0 == 192) {
            0x1::string::utf8(b"PWN NOOBS Chan")
        } else if (*v0 == 193) {
            0x1::string::utf8(b"Power Chan")
        } else if (*v0 == 194) {
            0x1::string::utf8(b"Disciple Chan")
        } else if (*v0 == 195) {
            0x1::string::utf8(b"Bruce Lee Chan")
        } else if (*v0 == 196) {
            0x1::string::utf8(b"For Mibus Only Chan")
        } else if (*v0 == 197) {
            0x1::string::utf8(b"Fishy Chan")
        } else if (*v0 == 198) {
            0x1::string::utf8(b"Holo Chan")
        } else if (*v0 == 199) {
            0x1::string::utf8(b"Solana Chan")
        } else {
            assert!(*v0 == 200, 0);
            0x1::string::utf8(b"Alien Chan")
        }
    }

    public fun new_u_metadata(arg0: &SquidMaidenAdminCap, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: u64) : UMetadata {
        UMetadata{
            background : arg1,
            eyes       : arg2,
            mouth      : arg3,
            hair       : arg4,
            hat        : arg5,
            back_item  : arg6,
            cloth      : arg7,
            number     : arg8,
        }
    }

    // decompiled from Move bytecode v6
}

