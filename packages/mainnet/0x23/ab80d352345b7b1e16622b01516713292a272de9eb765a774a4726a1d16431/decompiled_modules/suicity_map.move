module 0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map {
    struct CoordinateData has copy, drop {
        id: 0x2::object::ID,
        x: u64,
        y: u64,
        zone: 0x1::string::String,
    }

    struct Patch has copy, store {
        w: u64,
        h: u64,
        x: u64,
        y: u64,
        population: u64,
    }

    struct Town has store {
        section: u64,
        name: 0x1::string::String,
        population: u64,
        patches: vector<Patch>,
    }

    struct SuiCity has store, key {
        id: 0x2::object::UID,
        population: u64,
        towns: vector<Town>,
    }

    struct MapCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct SUICITY_MAP has drop {
        dummy_field: bool,
    }

    public fun createSuiCity(arg0: &mut 0x2::tx_context::TxContext) : SuiCity {
        let v0 = Patch{
            w          : 9,
            h          : 9,
            x          : 6,
            y          : 0,
            population : 81,
        };
        let v1 = Patch{
            w          : 5,
            h          : 7,
            x          : 15,
            y          : 2,
            population : 35,
        };
        let v2 = 0x1::vector::empty<Patch>();
        let v3 = &mut v2;
        0x1::vector::push_back<Patch>(v3, v0);
        0x1::vector::push_back<Patch>(v3, v1);
        let v4 = Town{
            section    : 1,
            name       : 0x1::string::utf8(b"Cypress Hill"),
            population : 116,
            patches    : v2,
        };
        let v5 = Patch{
            w          : 9,
            h          : 6,
            x          : 28,
            y          : 3,
            population : 54,
        };
        let v6 = Patch{
            w          : 6,
            h          : 6,
            x          : 37,
            y          : 0,
            population : 36,
        };
        let v7 = Patch{
            w          : 4,
            h          : 3,
            x          : 43,
            y          : 0,
            population : 12,
        };
        let v8 = 0x1::vector::empty<Patch>();
        let v9 = &mut v8;
        0x1::vector::push_back<Patch>(v9, v5);
        0x1::vector::push_back<Patch>(v9, v6);
        0x1::vector::push_back<Patch>(v9, v7);
        let v10 = Town{
            section    : 2,
            name       : 0x1::string::utf8(b"Blueberry Estate"),
            population : 102,
            patches    : v8,
        };
        let v11 = Patch{
            w          : 1,
            h          : 9,
            x          : 47,
            y          : 0,
            population : 9,
        };
        let v12 = Patch{
            w          : 8,
            h          : 11,
            x          : 48,
            y          : 0,
            population : 88,
        };
        let v13 = Patch{
            w          : 5,
            h          : 6,
            x          : 56,
            y          : 5,
            population : 30,
        };
        let v14 = 0x1::vector::empty<Patch>();
        let v15 = &mut v14;
        0x1::vector::push_back<Patch>(v15, v11);
        0x1::vector::push_back<Patch>(v15, v12);
        0x1::vector::push_back<Patch>(v15, v13);
        let v16 = Town{
            section    : 3,
            name       : 0x1::string::utf8(b"Alphabet City"),
            population : 127,
            patches    : v14,
        };
        let v17 = Patch{
            w          : 8,
            h          : 11,
            x          : 61,
            y          : 7,
            population : 88,
        };
        let v18 = Patch{
            w          : 2,
            h          : 6,
            x          : 69,
            y          : 9,
            population : 12,
        };
        let v19 = Patch{
            w          : 2,
            h          : 7,
            x          : 59,
            y          : 11,
            population : 14,
        };
        let v20 = 0x1::vector::empty<Patch>();
        let v21 = &mut v20;
        0x1::vector::push_back<Patch>(v21, v17);
        0x1::vector::push_back<Patch>(v21, v18);
        0x1::vector::push_back<Patch>(v21, v19);
        let v22 = Town{
            section    : 4,
            name       : 0x1::string::utf8(b"SuiSee"),
            population : 114,
            patches    : v20,
        };
        let v23 = Patch{
            w          : 11,
            h          : 11,
            x          : 48,
            y          : 11,
            population : 121,
        };
        let v24 = Patch{
            w          : 3,
            h          : 9,
            x          : 45,
            y          : 13,
            population : 27,
        };
        let v25 = 0x1::vector::empty<Patch>();
        let v26 = &mut v25;
        0x1::vector::push_back<Patch>(v26, v23);
        0x1::vector::push_back<Patch>(v26, v24);
        let v27 = Town{
            section    : 5,
            name       : 0x1::string::utf8(b"Oceanmile"),
            population : 148,
            patches    : v25,
        };
        let v28 = Patch{
            w          : 14,
            h          : 11,
            x          : 23,
            y          : 9,
            population : 154,
        };
        let v29 = Patch{
            w          : 1,
            h          : 9,
            x          : 37,
            y          : 11,
            population : 9,
        };
        let v30 = Patch{
            w          : 2,
            h          : 6,
            x          : 38,
            y          : 14,
            population : 12,
        };
        let v31 = Patch{
            w          : 5,
            h          : 4,
            x          : 40,
            y          : 16,
            population : 20,
        };
        let v32 = 0x1::vector::empty<Patch>();
        let v33 = &mut v32;
        0x1::vector::push_back<Patch>(v33, v28);
        0x1::vector::push_back<Patch>(v33, v29);
        0x1::vector::push_back<Patch>(v33, v30);
        0x1::vector::push_back<Patch>(v33, v31);
        let v34 = Town{
            section    : 6,
            name       : 0x1::string::utf8(b"Sunflower Fields"),
            population : 195,
            patches    : v32,
        };
        let v35 = Patch{
            w          : 11,
            h          : 11,
            x          : 12,
            y          : 9,
            population : 121,
        };
        let v36 = 0x1::vector::empty<Patch>();
        0x1::vector::push_back<Patch>(&mut v36, v35);
        let v37 = Town{
            section    : 7,
            name       : 0x1::string::utf8(b"Sky Hill"),
            population : 121,
            patches    : v36,
        };
        let v38 = Patch{
            w          : 13,
            h          : 8,
            x          : 6,
            y          : 20,
            population : 104,
        };
        let v39 = 0x1::vector::empty<Patch>();
        0x1::vector::push_back<Patch>(&mut v39, v38);
        let v40 = Town{
            section    : 8,
            name       : 0x1::string::utf8(b"Oceanview Heights"),
            population : 104,
            patches    : v39,
        };
        let v41 = Patch{
            w          : 21,
            h          : 4,
            x          : 19,
            y          : 20,
            population : 84,
        };
        let v42 = Patch{
            w          : 4,
            h          : 4,
            x          : 19,
            y          : 24,
            population : 16,
        };
        let v43 = Patch{
            w          : 4,
            h          : 4,
            x          : 36,
            y          : 24,
            population : 16,
        };
        let v44 = Patch{
            w          : 21,
            h          : 4,
            x          : 19,
            y          : 28,
            population : 84,
        };
        let v45 = 0x1::vector::empty<Patch>();
        let v46 = &mut v45;
        0x1::vector::push_back<Patch>(v46, v41);
        0x1::vector::push_back<Patch>(v46, v42);
        0x1::vector::push_back<Patch>(v46, v43);
        0x1::vector::push_back<Patch>(v46, v44);
        let v47 = Town{
            section    : 9,
            name       : 0x1::string::utf8(b"SuiteVille"),
            population : 200,
            patches    : v45,
        };
        let v48 = Patch{
            w          : 5,
            h          : 16,
            x          : 40,
            y          : 20,
            population : 80,
        };
        let v49 = Patch{
            w          : 5,
            h          : 5,
            x          : 45,
            y          : 22,
            population : 25,
        };
        let v50 = 0x1::vector::empty<Patch>();
        let v51 = &mut v50;
        0x1::vector::push_back<Patch>(v51, v48);
        0x1::vector::push_back<Patch>(v51, v49);
        let v52 = Town{
            section    : 10,
            name       : 0x1::string::utf8(b"Silver Shore"),
            population : 105,
            patches    : v50,
        };
        let v53 = Patch{
            w          : 11,
            h          : 8,
            x          : 46,
            y          : 36,
            population : 88,
        };
        let v54 = Patch{
            w          : 3,
            h          : 1,
            x          : 46,
            y          : 44,
            population : 3,
        };
        let v55 = Patch{
            w          : 2,
            h          : 1,
            x          : 55,
            y          : 44,
            population : 2,
        };
        let v56 = Patch{
            w          : 1,
            h          : 1,
            x          : 57,
            y          : 39,
            population : 1,
        };
        let v57 = Patch{
            w          : 5,
            h          : 9,
            x          : 57,
            y          : 40,
            population : 45,
        };
        let v58 = 0x1::vector::empty<Patch>();
        let v59 = &mut v58;
        0x1::vector::push_back<Patch>(v59, v53);
        0x1::vector::push_back<Patch>(v59, v54);
        0x1::vector::push_back<Patch>(v59, v55);
        0x1::vector::push_back<Patch>(v59, v56);
        0x1::vector::push_back<Patch>(v59, v57);
        let v60 = Town{
            section    : 11,
            name       : 0x1::string::utf8(b"Sapphire Shoals"),
            population : 139,
            patches    : v58,
        };
        let v61 = Patch{
            w          : 6,
            h          : 9,
            x          : 34,
            y          : 32,
            population : 54,
        };
        let v62 = Patch{
            w          : 6,
            h          : 8,
            x          : 40,
            y          : 36,
            population : 48,
        };
        let v63 = 0x1::vector::empty<Patch>();
        let v64 = &mut v63;
        0x1::vector::push_back<Patch>(v64, v61);
        0x1::vector::push_back<Patch>(v64, v62);
        let v65 = Town{
            section    : 12,
            name       : 0x1::string::utf8(b"Lakeside"),
            population : 102,
            patches    : v63,
        };
        let v66 = Patch{
            w          : 6,
            h          : 8,
            x          : 19,
            y          : 32,
            population : 48,
        };
        let v67 = Patch{
            w          : 9,
            h          : 9,
            x          : 25,
            y          : 32,
            population : 81,
        };
        let v68 = Patch{
            w          : 3,
            h          : 3,
            x          : 25,
            y          : 41,
            population : 9,
        };
        let v69 = 0x1::vector::empty<Patch>();
        let v70 = &mut v69;
        0x1::vector::push_back<Patch>(v70, v66);
        0x1::vector::push_back<Patch>(v70, v67);
        0x1::vector::push_back<Patch>(v70, v68);
        let v71 = Town{
            section    : 13,
            name       : 0x1::string::utf8(b"SuiSprings"),
            population : 138,
            patches    : v69,
        };
        let v72 = Patch{
            w          : 19,
            h          : 4,
            x          : 0,
            y          : 28,
            population : 76,
        };
        let v73 = Patch{
            w          : 11,
            h          : 3,
            x          : 8,
            y          : 32,
            population : 33,
        };
        let v74 = Patch{
            w          : 7,
            h          : 5,
            x          : 12,
            y          : 35,
            population : 35,
        };
        let v75 = Patch{
            w          : 4,
            h          : 4,
            x          : 13,
            y          : 40,
            population : 16,
        };
        let v76 = 0x1::vector::empty<Patch>();
        let v77 = &mut v76;
        0x1::vector::push_back<Patch>(v77, v72);
        0x1::vector::push_back<Patch>(v77, v73);
        0x1::vector::push_back<Patch>(v77, v74);
        0x1::vector::push_back<Patch>(v77, v75);
        let v78 = Town{
            section    : 14,
            name       : 0x1::string::utf8(b"Moon Heights"),
            population : 160,
            patches    : v76,
        };
        let v79 = Patch{
            w          : 5,
            h          : 4,
            x          : 0,
            y          : 35,
            population : 20,
        };
        let v80 = Patch{
            w          : 7,
            h          : 4,
            x          : 2,
            y          : 39,
            population : 28,
        };
        let v81 = Patch{
            w          : 7,
            h          : 8,
            x          : 3,
            y          : 43,
            population : 56,
        };
        let v82 = Patch{
            w          : 6,
            h          : 4,
            x          : 10,
            y          : 47,
            population : 24,
        };
        let v83 = 0x1::vector::empty<Patch>();
        let v84 = &mut v83;
        0x1::vector::push_back<Patch>(v84, v79);
        0x1::vector::push_back<Patch>(v84, v80);
        0x1::vector::push_back<Patch>(v84, v81);
        0x1::vector::push_back<Patch>(v84, v82);
        let v85 = Town{
            section    : 15,
            name       : 0x1::string::utf8(b"Silicon Heights"),
            population : 128,
            patches    : v83,
        };
        let v86 = Patch{
            w          : 15,
            h          : 10,
            x          : 16,
            y          : 47,
            population : 150,
        };
        let v87 = Patch{
            w          : 3,
            h          : 3,
            x          : 20,
            y          : 44,
            population : 9,
        };
        let v88 = 0x1::vector::empty<Patch>();
        let v89 = &mut v88;
        0x1::vector::push_back<Patch>(v89, v86);
        0x1::vector::push_back<Patch>(v89, v87);
        let v90 = Town{
            section    : 16,
            name       : 0x1::string::utf8(b"RiverWalk"),
            population : 159,
            patches    : v88,
        };
        let v91 = Patch{
            w          : 7,
            h          : 2,
            x          : 31,
            y          : 45,
            population : 14,
        };
        let v92 = Patch{
            w          : 10,
            h          : 7,
            x          : 31,
            y          : 47,
            population : 70,
        };
        let v93 = Patch{
            w          : 6,
            h          : 3,
            x          : 31,
            y          : 54,
            population : 18,
        };
        let v94 = Patch{
            w          : 9,
            h          : 8,
            x          : 37,
            y          : 54,
            population : 72,
        };
        let v95 = 0x1::vector::empty<Patch>();
        let v96 = &mut v95;
        0x1::vector::push_back<Patch>(v96, v91);
        0x1::vector::push_back<Patch>(v96, v92);
        0x1::vector::push_back<Patch>(v96, v93);
        0x1::vector::push_back<Patch>(v96, v94);
        let v97 = Town{
            section    : 17,
            name       : 0x1::string::utf8(b"SouthSui"),
            population : 174,
            patches    : v95,
        };
        let v98 = Patch{
            w          : 5,
            h          : 2,
            x          : 46,
            y          : 54,
            population : 10,
        };
        let v99 = Patch{
            w          : 13,
            h          : 6,
            x          : 46,
            y          : 56,
            population : 78,
        };
        let v100 = Patch{
            w          : 3,
            h          : 2,
            x          : 51,
            y          : 50,
            population : 6,
        };
        let v101 = Patch{
            w          : 3,
            h          : 2,
            x          : 59,
            y          : 56,
            population : 6,
        };
        let v102 = Patch{
            w          : 6,
            h          : 4,
            x          : 56,
            y          : 52,
            population : 24,
        };
        let v103 = Patch{
            w          : 4,
            h          : 3,
            x          : 58,
            y          : 49,
            population : 12,
        };
        let v104 = 0x1::vector::empty<Patch>();
        let v105 = &mut v104;
        0x1::vector::push_back<Patch>(v105, v98);
        0x1::vector::push_back<Patch>(v105, v99);
        0x1::vector::push_back<Patch>(v105, v100);
        0x1::vector::push_back<Patch>(v105, v101);
        0x1::vector::push_back<Patch>(v105, v102);
        0x1::vector::push_back<Patch>(v105, v103);
        let v106 = Town{
            section    : 18,
            name       : 0x1::string::utf8(b"Cosmos Corner"),
            population : 136,
            patches    : v104,
        };
        let v107 = 0x2::object::new(arg0);
        let v108 = MapCreated{id: 0x2::object::uid_to_inner(&v107)};
        0x2::event::emit<MapCreated>(v108);
        let v109 = 0x1::vector::empty<Town>();
        let v110 = &mut v109;
        0x1::vector::push_back<Town>(v110, v4);
        0x1::vector::push_back<Town>(v110, v10);
        0x1::vector::push_back<Town>(v110, v16);
        0x1::vector::push_back<Town>(v110, v22);
        0x1::vector::push_back<Town>(v110, v27);
        0x1::vector::push_back<Town>(v110, v34);
        0x1::vector::push_back<Town>(v110, v37);
        0x1::vector::push_back<Town>(v110, v40);
        0x1::vector::push_back<Town>(v110, v47);
        0x1::vector::push_back<Town>(v110, v52);
        0x1::vector::push_back<Town>(v110, v60);
        0x1::vector::push_back<Town>(v110, v65);
        0x1::vector::push_back<Town>(v110, v71);
        0x1::vector::push_back<Town>(v110, v78);
        0x1::vector::push_back<Town>(v110, v85);
        0x1::vector::push_back<Town>(v110, v90);
        0x1::vector::push_back<Town>(v110, v97);
        0x1::vector::push_back<Town>(v110, v106);
        SuiCity{
            id         : v107,
            population : 2468,
            towns      : v109,
        }
    }

    public entry fun get_coordinate(arg0: &SuiCity, arg1: u64) : CoordinateData {
        let v0 = arg1 * 19 % (2468 + 1);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0x1::vector::borrow<Town>(&arg0.towns, v1);
        let v4 = v3;
        let v5 = v3.population;
        while (v0 > v5) {
            v2 = v2 + 1;
            let v6 = 0x1::vector::borrow<Town>(&arg0.towns, v2);
            v4 = v6;
            v5 = v5 + v6.population;
        };
        let v7 = v0 - v5 - v4.population;
        let v8 = &v4.patches;
        let v9 = 0;
        let v10 = 0x1::vector::borrow<Patch>(v8, v9);
        let v11 = v10;
        let v12 = v10.population;
        while (v7 > v12) {
            let v13 = v9 + 1;
            v9 = v13;
            let v14 = 0x1::vector::borrow<Patch>(v8, v13);
            v11 = v14;
            v12 = v12 + v14.population;
        };
        let v15 = v7 - v12 - v11.population - 1;
        CoordinateData{
            id   : 0x2::object::id<SuiCity>(arg0),
            x    : v15 % v11.w + v11.x,
            y    : v15 / v11.w + v11.y,
            zone : v4.name,
        }
    }

    public fun get_x(arg0: CoordinateData) : u64 {
        arg0.x
    }

    public fun get_y(arg0: CoordinateData) : u64 {
        arg0.y
    }

    public fun get_zone(arg0: CoordinateData) : 0x1::string::String {
        arg0.zone
    }

    fun init(arg0: SUICITY_MAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SUICITY_MAP>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<SuiCity>(createSuiCity(arg1));
    }

    // decompiled from Move bytecode v6
}

